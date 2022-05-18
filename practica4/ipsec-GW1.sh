#!/usr/sbin/setkey -f
flush;
spdflush;

#AH
add 10.0.0.1 10.0.3.2 ah 1234 -A hmac-md5 "9876554394873717";
add 10.0.3.2 10.0.0.1 ah 1235 -A hmac-md5 "9484929385200593";

# ESP
add 10.0.0.1 10.0.3.2 esp 1236 -E 3des-cbc "123456788881344568799809";
add 10.0.3.2 10.0.0.1 esp 1237 -E 3des-cbc "119191919191991834757483";

spdadd 10.0.0.1 10.0.3.2 any -P out ipsec
    esp/transport//require
    ah/transport//require;

spdadd 10.0.3.2 10.0.0.1 any -P in ipsec

    esp/transport//require
    ah/transport//require;
