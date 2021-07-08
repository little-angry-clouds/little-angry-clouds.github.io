# Little Angry Cloud's Web Page

This is [Little Angry Clouds's](https://little-angry-clouds.github.io/) web page.

There's actually:
- A [helm](https://helm.sh) repository.
- Some hosted talks

## Helm Repository
To configure this repository, you may execute the next command in your computer:

```bash
helm repo add little-angry-clouds https://little-angry-clouds.github.io/
```

To test that it's configured correctly, search the chart
`haproxy-network-ingress`:

```bash
helm search -r "^haproxy-network-ingress"
```

It should return: `little-angry-clouds/haproxy-network-ingress`.

## Talks
- [OpenEBS in Spanish](https://little-angry-clouds.github.io/talks/openebs/2021-01/index.html)
