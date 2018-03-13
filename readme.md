# Kong Consumer Interval Plugin
With this plugin you are allowed to alocate a specific time interval for your api consumers. In this version you can set only intervals in each minute from **0** to **59**. For example you can alocate for consumer **A** an interval between **0** and **30** and for consumer **B** an interval between **31** and **59**. This thing means that consumer **A** can make API calls in every minute between secunds **0** and **30** and consumer **B** between secunds **31** and **59**. In association with [rate-limiting-plugin](https://getkong.org/plugins/rate-limiting/) you can distribute homogeneously your api requests and avoid requests spikes.

#### Configuration
You can configure the plugin by executing the following request on your Kong server:
```
POST http://kong:8001/plugins
{
    "name":"consumer-interval",
    "consumer_id": "<consumer-id>",
    "config": {
        "interval_start": 0,
        "interval_end": 10
    }
}
```

#### Headers sent to the client
When you use this plugin and client make calls outside their interval, Kong will send some additional headers back to the client telling how many seconds remaining until client can make next requests:
```
X-NextAvailableRequests-StartIn: 25
X-NextAvailableRequests-StopIn: 35
```
and respond with the folowing message `HTTP/1.1 403`:
```
{"message":"You can make next api call in 25 seconds"}
```

# Installing the plugin

#### install it locally (based on the `.rockspec` in the current directory)
$ luarocks make kong-plugin-consumer-interval-0.1.rockspec

#### pack the installed rock
$ luarocks pack kong-plugin-consumer-interval 0.1

# Load the plugin
You must now add the custom plugin's name to the custom_plugins list in your Kong configuration (on each Kong node):

custom_plugins = consumer-interval

If you are using two or more custom plugins, insert commas in between, like so:

custom_plugins = plugin1,plugin2

For more information visit [Plugin Development - (un)Install your plugin](https://getkong.org/docs/0.10.x/plugin-development/distribution/)
