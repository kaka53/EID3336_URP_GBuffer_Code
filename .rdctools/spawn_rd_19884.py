import os, subprocess, time

port = "19884"
env = os.environ.copy()
env["AGENTIC_EMBEDDED_CAPTURE"] = r"F:\endfield06.rdc"
env["AGENTIC_EMBEDDED_PORT_MIN"] = port
env["AGENTIC_EMBEDDED_PORT_MAX"] = port
env["AGENTIC_EMBEDDED_PKG_PARENT"] = r"C:\Users\Administrator\.l-skill\work\renderdoc-link\agentic-renderdoc\src"
env["AGENTIC_DISABLE_AUTOLOAD"] = "1"
log = os.path.join(os.environ.get("TEMP", "."), "agentic-renderdoc-embedded-%s.log" % port)
if os.path.exists(log):
    os.remove(log)
flags = 0x00000008 | 0x00000200  # DETACHED_PROCESS | CREATE_NEW_PROCESS_GROUP
p = subprocess.Popen(
    [
        r"C:\Program Files\RenderDoc\qrenderdoc.exe",
        "--script",
        r"C:\Users\Administrator\.l-skill\work\renderdoc-link\agentic-renderdoc\src\extension\embedded_headless.py",
    ],
    env=env,
    close_fds=True,
    creationflags=flags,
)
print("pid", p.pid)
time.sleep(1)
print("log_exists", os.path.exists(log))
