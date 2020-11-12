#! /bin/bash
rm -rf /etc/localtime
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
date -R

mkdir /trojanbin
cd /trojanbin
wget --no-check-certificate -qO 'trojango.zip' "https://github.com/p4gefau1t/trojan-go/releases/download/v0.8.2/trojan-go-linux-amd64.zip"
ls
unzip trojango.zip
rm -rf trojango.zip
ls
chmod +x /trojanbin/*

cat > /trojanbin/server.json <<-EOF
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 1080,
    "remote_addr": "127.0.0.1",
    "remote_port": 80,
    "password": [
        ${PassWord}
    ],
    "log_level": 1,
    "ssl": {
        "cert": "/etc/ssl/certs/cert.pem",
        "key": "/etc/ssl/private/key.pem",
        "key_password": "",
	    "prefer_server_cipher": false,
        "alpn": [
            "http/1.1"
        ],
        "reuse_session": true,
        "session_ticket": false,
        "session_timeout": 600,
        "plain_http_response": "",
        "curves": "",
        "dhparam": "",
        "fingerprint": "firefox"
    },
    "tcp": {
        "no_delay": true,
        "keep_alive": true
    },
    "websocket": {
        "enabled": true,
        "path": "/",
        "host": ""
    },
    "mysql": {
        "enabled": false,
        "server_addr": "127.0.0.1",
        "server_port": 3306,
        "database": "trojan",
        "username": "trojan",
        "password": ""
    }
}
EOF

cd /trojanbin
./trojan-go -config /trojanbin/server.json
