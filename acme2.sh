for i in `cat yuming.txt`;do  /root/.acme.sh/acme.sh --issue  -d "*.${i}" -d ${i}  --dns  --yes-I-know-dns-manual-mode-enough-go-ahead-please --renew ;done

