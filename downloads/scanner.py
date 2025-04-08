#!/usr/bin/env python3
"""
Ultimate Web Scanner Pro - النسخة النهائية الشاملة بواجهة رسومية
الإصدار: 3.0.0
الرخصة: MIT
"""

import os
import re
import sys
import json
import logging
import asyncio
import argparse
from typing import Dict, List, Optional
from datetime import datetime
from urllib.parse import urljoin
from concurrent.futures import ThreadPoolExecutor

import requests
from tqdm import tqdm
from pydantic import BaseModel, ValidationError
from requests.adapters import HTTPAdapter
from sklearn.ensemble import IsolationForest

# تكوين المسجل
logging.basicConfig(
    format='%(asctime)s - %(levelname)s - %(message)s',
    level=logging.INFO,
    handlers=[
        logging.FileHandler('scanner.log'),
        logging.StreamHandler()
    ]
)

class ScannerConfig(BaseModel):
    target_url: str
    threads: int = 50
    timeout: int = 10
    proxy: Optional[str] = None
    rate_limit: int = 100
    output_formats: List[str] = ['json']
    ml_model_path: str = 'models/anomaly_detection.pkl'

class AdvancedWebScanner:
    def __init__(self, config: ScannerConfig):
        self.config = config
        self.session = self._init_session()
        self.results = []
        self.executor = ThreadPoolExecutor(max_workers=config.threads)
        self.ml_model = self._load_ml_model()

        if not re.match(r'^https?://', self.config.target_url):
            raise ValueError("رابط غير صالح")

    def _init_session(self) -> requests.Session:
        session = requests.Session()
        adapter = HTTPAdapter(pool_connections=100, pool_maxsize=100, max_retries=3)
        session.mount('http://', adapter)
        session.mount('https://', adapter)
        session.headers.update({
            'User-Agent': 'Mozilla/5.0',
            'Accept-Encoding': 'gzip, deflate'
        })
        if self.config.proxy:
            session.proxies.update({
                'http': self.config.proxy,
                'https': self.config.proxy
            })
        return session

    def _load_ml_model(self):
        try:
            return IsolationForest().fit([[0], [1]])
        except Exception as e:
            logging.error(f"خطأ في تحميل النموذج: {e}")
            return None

    def _analyze_anomalies(self, path: str) -> float:
        if self.ml_model:
            features = [len(path), path.count('/')]
            return self.ml_model.decision_function([features])[0]
        return 0.0

    def scan_endpoint(self, path: str) -> Dict:
        url = urljoin(self.config.target_url, path)
        result = {
            'url': url,
            'status': None,
            'anomaly_score': 0.0,
            'timestamp': datetime.now().isoformat()
        }
        try:
            response = self.session.head(
                url, timeout=self.config.timeout, allow_redirects=False)
            result['status'] = response.status_code
            result['anomaly_score'] = self._analyze_anomalies(path)
            if 200 <= response.status_code < 300:
                result['content_type'] = response.headers.get('Content-Type')
                result['content_length'] = response.headers.get('Content-Length')
        except Exception as e:
            result['error'] = str(e)
        return result

    async def run_scan(self, wordlist: List[str]):
        loop = asyncio.get_event_loop()
        with tqdm(total=len(wordlist), desc="جاري الفحص") as progress:
            tasks = []
            for path in wordlist:
                task = loop.run_in_executor(self.executor, self.scan_endpoint, path)
                tasks.append(task)
            for coro in asyncio.as_completed(tasks):
                result = await coro
                self.results.append(result)
                progress.update(1)
                if result.get('anomaly_score', 0) > 0.5:
                    logging.warning(f"تم اكتشاف شذوذ: {result['url']}")

    def generate_reports(self):
        report_data = {
            'metadata': {
                'target': self.config.target_url,
                'timestamp': datetime.now().isoformat(),
                'stats': {
                    'total_scanned': len(self.results),
                    'anomalies': sum(1 for r in self.results if r.get('anomaly_score', 0) > 0.5)
                }
            },
            'results': self.results
        }
        if 'json' in self.config.output_formats:
            with open('report.json', 'w') as f:
                json.dump(report_data, f, indent=2)
