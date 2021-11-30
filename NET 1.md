#### *************************1*************************

```
openssl s_client -connect stackoverflow.com:443
```

depth=2 C = US, O = Internet Security Research Group, CN = ISRG Root X1
verify return:1
depth=1 C = US, O = Let's Encrypt, CN = R3
verify return:1
depth=0 CN = *.stackexchange.com
verify return:1

CONNECTED(00000003)

Certificate chain
 0 s:CN = *.stackexchange.com
   i:C = US, O = Let's Encrypt, CN = R3
 1 s:C = US, O = Let's Encrypt, CN = R3
   i:C = US, O = Internet Security Research Group, CN = ISRG Root X1
 2 s:C = US, O = Internet Security Research Group, CN = ISRG Root X1

   i:O = Digital Signature Trust Co., CN = DST Root CA X3

Server certificate
-----BEGIN CERTIFICATE-----
MIIG9TCCBd2gAwIBAgISBAkfuZC5JKnOvxe/UlHKIkZnMA0GCSqGSIb3DQEBCwUA
MDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQD
EwJSMzAeFw0yMTExMDQxMzE2MzFaFw0yMjAyMDIxMzE2MzBaMB4xHDAaBgNVBAMM
Eyouc3RhY2tleGNoYW5nZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQCedHiinbubFcVBED9vVvjMKf8o+vc0NfeCupVlA4Lflam+9P6rGFllv7QZ
Cl/kpZ711tMN58TUIi52VyWjnIih7Rw/DIq3SaSe+5XIlv5R7EOuDVvqMFjtzU4d
XmAOSVSLjy/1g1sGIJizUeyydWBXCRiFWtzG0ChzcqVA7w0nmtP9zL3RTSUJ3ald
pjgYDyE5a3o5dTIeAfJ3v4qGbQxmRuqV5AvhxDkxxs8zk8bYRqFBpxXYg1dc1HCL
JG2iHt/wpqGXMEd8fA6dh7J8BCbkaZQ649E5KuhKf34q9pfQwjeWLikrtVlOSn4i
83pyYEEBB2stVuC74RE6KoRB6L61AgMBAAGjggQXMIIEEzAOBgNVHQ8BAf8EBAMC
BaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMAwGA1UdEwEB/wQCMAAw
HQYDVR0OBBYEFF/k6qarUBAuKg4f/RGP8dsAZ34bMB8GA1UdIwQYMBaAFBQusxe3
WFbLrlAJQOYfr52LFMLGMFUGCCsGAQUFBwEBBEkwRzAhBggrBgEFBQcwAYYVaHR0
cDovL3IzLm8ubGVuY3Iub3JnMCIGCCsGAQUFBzAChhZodHRwOi8vcjMuaS5sZW5j
ci5vcmcvMIIB5AYDVR0RBIIB2zCCAdeCDyouYXNrdWJ1bnR1LmNvbYISKi5ibG9n
b3ZlcmZsb3cuY29tghIqLm1hdGhvdmVyZmxvdy5uZXSCGCoubWV0YS5zdGFja2V4
Y2hhbmdlLmNvbYIYKi5tZXRhLnN0YWNrb3ZlcmZsb3cuY29tghEqLnNlcnZlcmZh
dWx0LmNvbYINKi5zc3RhdGljLm5ldIITKi5zdGFja2V4Y2hhbmdlLmNvbYITKi5z
dGFja292ZXJmbG93LmNvbYIVKi5zdGFja292ZXJmbG93LmVtYWlsgg8qLnN1cGVy
dXNlci5jb22CDWFza3VidW50dS5jb22CEGJsb2dvdmVyZmxvdy5jb22CEG1hdGhv
dmVyZmxvdy5uZXSCFG9wZW5pZC5zdGFja2F1dGguY29tgg9zZXJ2ZXJmYXVsdC5j
b22CC3NzdGF0aWMubmV0gg1zdGFja2FwcHMuY29tgg1zdGFja2F1dGguY29tghFz
dGFja2V4Y2hhbmdlLmNvbYISc3RhY2tvdmVyZmxvdy5ibG9nghFzdGFja292ZXJm
bG93LmNvbYITc3RhY2tvdmVyZmxvdy5lbWFpbIIRc3RhY2tzbmlwcGV0cy5uZXSC
DXN1cGVydXNlci5jb20wTAYDVR0gBEUwQzAIBgZngQwBAgEwNwYLKwYBBAGC3xMB
AQEwKDAmBggrBgEFBQcCARYaaHR0cDovL2Nwcy5sZXRzZW5jcnlwdC5vcmcwggEF
BgorBgEEAdZ5AgQCBIH2BIHzAPEAdgDfpV6raIJPH2yt7rhfTj5a6s2iEqRqXo47
EsAgRFwqcwAAAXzrTu93AAAEAwBHMEUCIDy+WAPUB63bo6Wk/nIJ8U9bEOHWOOS+
hFOZ6UYzpuHiAiEA4dZ3H+eF+EjCOjI6V4lvAeyPolXYIPCfTGxS5e0i2jIAdwBG
pVXrdfqRIDC1oolp9PN9ESxBdL79SbiFq/L8cP5tRwAAAXzrTu+kAAAEAwBIMEYC
IQCDmJ+F8wo2NHas4bOsRhaczo+0KEDhfd+Axj6lJVAVJgIhAI6ViN94MkzaVbKa
43RFxfN+MUGF3ha3sQw9OvfHbrvHMA0GCSqGSIb3DQEBCwUAA4IBAQCgDInxPvUG
ffbVlD3uYuZX05qLzeZgRsMcnKUpG41Kn6pWhJ9sm0AOPzpqgs5JzJRJObarhrn4
r8viP9lQVVkQORh1+vD5KgGN0hsLnjmANYNKO3UpmczGSlQF1Ko+vMkaDF6D3K5O
d5Nf0Ife3cnF3xAx5j+16EI+PWUMqC5gyQekk3IiyAjo5pCRFejNiQBCRUp08ChB
ON1klCfyLC5601wsxIVJLHU+UUHUU8rdJ0YUu4+iC/IixYUEZ/yiads9ctmqvrpT
2HwOOzvskoU8K/mEQJcAwwXXDThDkDpzPjdDJkzxm6AGrPEbXzDj3PE7Oba2j+0v
rfcXTm/hUU/q
-----END CERTIFICATE-----
subject=CN = *.stackexchange.com

issuer=C = US, O = Let's Encrypt, CN = R3

---
No client certificate CA names sent
Peer signing digest: SHA256
Peer signature type: RSA-PSS

Server Temp Key: X25519, 253 bits

SSL handshake has read 5138 bytes and written 402 bytes

Verification: OK

New, TLSv1.2, Cipher is ECDHE-RSA-AES128-GCM-SHA256
Server public key is 2048 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ECDHE-RSA-AES128-GCM-SHA256
    Session-ID: 687D2AED2F5E69CAAB4D6B49C3F7A9085EB53A8DDED8C5F5C749E815123AE475
    Session-ID-ctx: 
    Master-Key: 4AC48268F131A6CE3CAD6B94594BA9CF9AAE986F18A48E9323E0E63CAD0ABFE9937866B6C80E31F0CEEA25646B9CBF94
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    TLS session ticket lifetime hint: 7200 (seconds)
    TLS session ticket:
    0000 - 21 31 e2 86 76 2e eb ac-a8 4a 15 d7 9d 9d 1b 00   !1..v....J......
    0010 - e9 21 f4 3f 28 c5 99 37-fd 7a eb 1f a1 57 3d 9a   .!.?(..7.z...W=.
    0020 - 0d 36 6f d3 dd 3f a0 42-5f c6 49 4c 9a 66 ad ad   .6o..?.B_.IL.f..
    0030 - 98 05 04 5d 2d a5 db 42-94 28 b4 be fb 06 d6 a4   ...]-..B.(......
    0040 - 47 d5 e4 5a bc 17 13 97-67 7c aa 5a 70 30 b7 6b   G..Z....g|.Zp0.k
    0050 - fc 17 38 7c 6d ab c1 cc-c5 8d 41 02 fe 16 d3 a9   ..8|m.....A.....
    0060 - b3 07 92 78 a2 5f 74 0c-17 22 0e ba a6 ee f2 2b   ...x._t..".....+
    0070 - 40 88 cb 80 c4 a9 dc 63-9e ed 6a 09 75 51 ae 60   @......c..j.uQ.`
    0080 - 10 74 2a 11 49 9c 26 82-5b 8f f9 d6 96 cd 76 b7   .t*.I.&.[.....v.
    0090 - 5d 31 2b 07 fa 59 75 80-89 b6 15 62 a7 67 c4 69   ]1+..Yu....b.g.i
    00a0 - 37 7c 1f e1 67 c1 8a 3a-2b 6e f2 39 82 14 14 22   7|..g..:+n.9..."
    00b0 - 9c 34 f2 93 d2 5d 6e fa-bb e2 c9 ae 82 43 b5 0c   .4...]n......C..

Start Time: 1638256101
Timeout   : 7200 (sec)
Verify return code: 0 (ok)
Extended master secret: yes

---
```
GET /questions HTTP/1.0
HOST: stackoverflow.com
```

HTTP/1.1 200 OK
Connection: close
cache-control: private
content-type: text/html; charset=utf-8
strict-transport-security: max-age=15552000
x-frame-options: SAMEORIGIN
x-request-guid: 397c3d8f-11d8-4cb0-a335-3048e434246d
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
Accept-Ranges: bytes
Date: Tue, 30 Nov 2021 07:09:00 GMT
Via: 1.1 varnish
X-Served-By: cache-hhn4079-HHN
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1638256140.011611,VS0,VE101
Vary: Fastly-SSL
X-DNS-Prefetch-Control: off
Set-Cookie: prov=da8dba15-dd47-878f-ecc7-ff0177e598ad; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

<!DOCTYPE html>


<html class="html__responsive ">

........
    </html>
closed

В данном случае указана версия HTTP-протокола, HTTP код состояния, сообщающий об успешности запроса. Запрашиваемая страница полностью получена и передана в теле сообщения.

В случае с telnet
HTTP/1.1 301 Moved Permanently
cache-control: no-cache, no-store, must-revalidate
location: https://stackoverflow.com/questions
x-request-guid: ea043fdf-8412-46a3-a968-d16859b586b9
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
Accept-Ranges: bytes
Date: Tue, 30 Nov 2021 07:24:48 GMT
Via: 1.1 varnish
Connection: close
X-Served-By: cache-hhn4080-HHN
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1638257089.857009,VS0,VE86
Vary: Fastly-SSL
X-DNS-Prefetch-Control: off
Set-Cookie: prov=b56b2338-ec0b-c897-3fc8-f9525b67cf10; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

URL-адрес запрошенного ресурса был изменен. 
ресурсы, которые мы запрашиваем, работает по https, а telnet может работать только по http

#### *************************2*************************

https

#### *************************3*************************

Мой IP: **185.6.117.173**

#### *************************4*************************

descr:          LLC Real-Net
origin:         AS198520

#### *************************5*************************

traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  10.0.2.2 [*]  0.078 ms  0.047 ms  0.102 ms
 2  * * *
 3  * * *
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  * * *
 9  * * *
10  * * *
11  * * *
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * * *
24  * * *
25  * * *
26  * * *
27  * * *
28  * * *
29  * * *
30  * * *

#### *************************6*************************

https

216.239.49.107

#### *************************7*************************

```
dig -t ANY dns.google.com +noall +answer
```

dns.google.com.		521	IN	A	8.8.8.8
dns.google.com.		521	IN	A	8.8.4.4
dns.google.com.		832	IN	AAAA	2001:4860:4860::8888
dns.google.com.		832	IN	AAAA	2001:4860:4860::8844

#### *************************8*************************

`dig -x 8.8.8.8`

; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.8.8
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 17721
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;8.8.8.8.in-addr.arpa.		IN	PTR

;; ANSWER SECTION:
8.8.8.8.in-addr.arpa.	5376	IN	PTR	dns.google.

;; Query time: 4 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Tue Nov 30 08:40:21 UTC 2021
;; MSG SIZE  rcvd: 73

```
dig -x 8.8.4.4
```

; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.4.4
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 6954
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.		IN	PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.	55434	IN	PTR	dns.google.

;; Query time: 3 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Tue Nov 30 08:41:09 UTC 2021
;; MSG SIZE  rcvd: 73

```
dig -x 2001:4860:4860::8888
```

; <<>> DiG 9.16.1-Ubuntu <<>> -x 2001:4860:4860::8888
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 21205
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;8.8.8.8.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.8.4.0.6.8.4.1.0.0.2.ip6.arpa. IN PTR

;; ANSWER SECTION:
8.8.8.8.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.8.4.0.6.8.4.1.0.0.2.ip6.arpa. 86400	IN PTR dns.google.

;; Query time: 359 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Tue Nov 30 08:41:43 UTC 2021
;; MSG SIZE  rcvd: 125