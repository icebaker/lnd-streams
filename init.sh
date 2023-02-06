export $(grep -v '^#' .env | xargs)

if [ $LND_STREAMS_ENVIRONMENT = 'development' ]; then
  bundle exec rerun -- rackup --server puma -p $LND_STREAMS_PORT
else
  bundle exec rackup --server puma -p $LND_STREAMS_PORT
fi
