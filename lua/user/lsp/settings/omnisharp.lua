local pid = vim.fn.getpid()
return {
    cmd = { 'OmniSharp', '--languageserver', '--hostPID', tostring(pid) }
}
