# Lightning Network Streams

> ⚠️ Warning: Early-stage, breaking changes are expected.

Connects to an [LND](https://github.com/lightningnetwork/lnd) node and forwards events to [Redpanda](https://github.com/redpanda-data/redpanda) topics.

## Running

Copy the `.env.example` file to `.env` and provide the required data.

```sh
bundle
./init.sh
```

## Development

```sh
bundle
rubocop -A
```
