# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Endpoints

### create a new subscription

`POST /api/v1/customer_subscriptions`

fields (passed in body)
customer_id - integer (required) - ID of subscribing customer
subscription_id - integer (required) - ID of subscription plan
frequency - string - available options: 'weekly', 'monthly, 'yearly' - default: 'monthly'

sample response
```
{
    "data": {
        "id": "1",
        "type": "customer_subscription",
        "attributes": {
            "customer_id": 1,
            "subscription_id": 1,
            "frequency": "monthly",
            "status": "active"
        }
    }
}
```

### cancel a subscription

'PATCH /api/v1/customer_subscriptions/{id}'

This endpoint is intended to function as a way to cancel a subscription without deleting its record, allowing customers to view both active and cancelled subscriptions.

params
id - integer (required) - ID of the customer_subscription to be cancelled

fields (passed in body)
status - string - 'cancelled'
frequency - string - available options: 'weekly', 'monthly, 'yearly' - default: 'monthly'

sample response
```
{
    "data": {
        "id": "2",
        "type": "customer_subscription",
        "attributes": {
            "customer_id": 1,
            "subscription_id": 1,
            "frequency": "monthly",
            "status": "cancelled"
        }
    }
}
```
