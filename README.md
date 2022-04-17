# fly-keydb-serf

```
fly launch --name keydb-test --region fra --no-deploy
fly secrets set KEYDB_PASSWORD=<sekret>
fly deploy

fly regions set fra ord ams
fly regions backup set
fly scale count 3 --max-per-region 1
```

#### Notes:
- no persistence storage was added to this setup,
- needs wireguard to access cluster members over vpn, nothing exposed publicly here.

#### Check, monitor cluster membership etc. via serf-cli:
```sh
serf members -rpc-addr=keydb-test.internal:7373
serf monitor -rpc-addr=keydb-test.internal:7373 -log-level=trace
```
