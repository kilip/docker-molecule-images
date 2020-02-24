"""Testing Service"""

def test_installation(host):
    certbot = host.package('certbot')
    nginx = host.package('nginx')

    assert certbot.is_installed
    assert nginx.is_installed

def test_service(host):
    nginx = host.service('nginx')

    assert nginx.is_enabled
    assert nginx.is_running
