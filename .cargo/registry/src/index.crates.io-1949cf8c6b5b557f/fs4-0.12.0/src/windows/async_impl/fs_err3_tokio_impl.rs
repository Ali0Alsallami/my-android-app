use std::io::{Error, Result};
use std::mem;
use std::os::windows::io::AsRawHandle;

use windows_sys::Win32::Foundation::HANDLE;
use windows_sys::Win32::Storage::FileSystem::{
    FileAllocationInfo, FileStandardInfo, GetFileInformationByHandleEx, LockFileEx,
    SetFileInformationByHandle, UnlockFile, FILE_ALLOCATION_INFO, FILE_STANDARD_INFO,
    LOCKFILE_EXCLUSIVE_LOCK, LOCKFILE_FAIL_IMMEDIATELY,
};

use fs_err3::tokio::File;

lock_impl!(File);
allocate!(File);
allocate_size!(File);

test_mod! {
  tokio::test,
  use crate::fs_err3_tokio::AsyncFileExt;
  use fs_err3::tokio as fs;
}
