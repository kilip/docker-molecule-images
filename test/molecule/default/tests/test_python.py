"""Role testing files using testinfra."""

def test_python_version(host):
    """Assert that python installed"""
    py    = host.run('python --version')
    pip   = host.run('pip --version')
    version = py.stdout

    if version == "":
      version = py.stderr

    assert py.rc == 0
    assert version.find('Python') == 0

    assert pip.rc == 0
    assert pip.stdout.find('pip') == 0
