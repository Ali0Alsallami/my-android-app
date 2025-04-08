# واجهة نصية باستخدام Textual
from textual.app import App, ComposeResult
from textual.containers import Container
from textual.widgets import Header, Footer, Input, Button, Static
import asyncio
import os

class ScannerUI(App):
    CSS_PATH = "styles.css"

    def compose(self) -> ComposeResult:
        yield Header()
        yield Container(
            Static("Ultimate Web Scanner Pro - Mobile UI"),
            Input(placeholder="أدخل الرابط المستهدف", id="target_url"),
            Input(placeholder="عدد الخيوط (threads)", id="threads"),
            Input(placeholder="مسار ملف الكلمات", id="wordlist"),
            Button("بدء الفحص", id="start"),
            id="main"
        )
        yield Footer()

    async def on_button_pressed(self, event: Button.Pressed):
        if event.button.id == "start":
            url = self.query_one("#target_url", Input).value
            threads = self.query_one("#threads", Input).value or "50"
            wordlist = self.query_one("#wordlist", Input).value
            if url and wordlist:
                cmd = f"python3 scanner.py {url} -t {threads} -w {wordlist}"
                os.system(cmd)

if __name__ == "__main__":
    ScannerUI().run()
