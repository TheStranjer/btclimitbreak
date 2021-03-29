# What Is This

A bot that posts to the fediverse every time BitCoin rallies past its previous maximum. Will be extremely obnoxious when it's pushing past its limit but entirely silent otherwise. You can follow the main iteration of this on `@btclimitbreak@iddqd.social`.

# Run Your Own

That's easy, just do the following:

```bash
git clone git@github.com:TheStranjer/btclimitbreak.git`
cd btclimitbreak
bundle install
bundle exec ruby ./btclimitbreak.rb
```

You will need to create a `credentials.json` file with your fediverse credentials. It might look like:

```json
{
	"bearer_token": "gobbledygook here",
	"instance": "iddqd.social"
}
```