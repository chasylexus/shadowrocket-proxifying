# shadowrocket-proxifying

Public Shadowrocket routing profile with the same business split as the local Surge profile.

This repository contains routing logic only. Do not put TT endpoints, server addresses, usernames, passwords, SNI values, client IDs, certificates, or other private values in this repo.

## Policy Names

Configure servers or policy groups outside this profile with these exact names:

```text
PROXY_T
PROXY_A
```

When Shadowrocket TrustTunnel support is available, attach your TT servers to those policy names outside this public config. They may point to the same TT endpoint internally if you want, but the routing layer keeps `T` and `A` separate.

## Business Logic

- `PROXY_T`: Google AI / Gemini / NotebookLM, Last.fm, plus the broad T proxy list.
- `PROXY_A`: manual A diagnostics, `whatismyip.com`, Netflix, Hulu, Disney+, HBO/Max, ESPN, Prime Video, Peacock, and related streaming domains.
- `DIRECT`: captive portals, LAN/local ranges, Apple/iCloud baseline, and final fallback.
- `REJECT`: ad/malware-style public reject lists.

Apple TV+ is intentionally not routed through `PROXY_A`.

`whatismyip.com` is pinned before the broad DIRECT baseline, including its IPv6 probe domains when the current network supports IPv6.

## Files

```text
shadowrocket.conf
shadowrocket.ruleset.direct.list
shadowrocket.ruleset.proxy-a.list
shadowrocket.ruleset.proxy-t-priority.list
shadowrocket.ruleset.proxy-t.list
shadowrocket.ruleset.proxy-t-ip.list
shadowrocket.ruleset.proxy-t-late.list
scripts/check-urls.sh
```

The BlackMatrix7 upstreams use Shadowrocket paths, for example:

```text
https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/refs/heads/master/rule/Shadowrocket/Netflix/Netflix.list
```

## Update Model

Import or subscribe to:

```text
https://raw.githubusercontent.com/chasylexus/shadowrocket-proxifying/refs/heads/main/shadowrocket.conf
```

The profile references public remote rule-set files. Refresh the profile/rule resources in Shadowrocket after pushing changes to GitHub.

## Validate Public URLs

From this repo:

```sh
sh scripts/check-urls.sh
```

The script checks the public remote rule resources and reports HTTP status codes only.
