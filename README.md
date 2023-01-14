# Tea Time API

![ruby](https://img.shields.io/static/v1?message=2.7.4&logo=ruby&style=for-the-badge&label=Ruby&color=darkred&labelColor=crimson) ![ror](https://img.shields.io/static/v1?message=5.2.8.1&logo=rubyonrails&style=for-the-badge&label=Rails&color=crimson&labelColor=darkred) ![Postgres](https://img.shields.io/static/v1?message=14.6&=postgresql&style=for-the-badge&label=Postgresql&color=dodgerblue&labelColor=royalblue&logoColor=white) ![postman](https://img.shields.io/static/v1?message=POSTMAN&logo=postman&style=for-the-badge&label=&color=orangered&labelColor=darkorange&logoColor=white)

### Dependencies

- jsonapi-serializer
- rspec-rails

### Configuration

[Fork this repository](https://github.com/ajkrumholz/tea_time)

run `bundle install`

### Database creation

run `rails db:{create,migrate}`

### Database initialization

run `rails db:seed` if seeded data is necessary

### Database Diagram

![database diagram](./app/assets/images/database_schema.png)

### Run the test suite

`bundle exec rspec`

## Endpoints

### Create a new subscription

`POST /api/v1/customer_subscriptions`

#### Fields (passed in request body)
- `customer_id` - integer (required) - ID of subscribing customer
- `subscription_id` - integer (required) - ID of subscription plan
- `frequency` - string - available options: 'weekly', 'monthly, 'yearly' - default: 'monthly'

#### Sample Request Body

```
{
    "customer_id": "1",
    "subscription_id": "1",
    "frequency": "yearly"
}
```

#### Sample Response
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

### Cancel a subscription

`PATCH /api/v1/customer_subscriptions/`

This endpoint is intended to function as a way to cancel a subscription without deleting its record. It can also be used to change the frequency of a customer's subscription.

#### Fields (passed in request body)
- `customer_subscription_id` - integer (required)
- `status` - string - 'cancelled'
- `frequency` - string - available options: 'weekly', 'monthly, 'yearly' - default: 'monthly'

#### Sample Request Body
```
POST /api/v1/customer_subscriptions/
{
    "customer_subscription_id": 2,
    "status": "cancelled"
}
```

#### Sample response
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

### Get subscription information for a customer

`GET /api/v1/customers/subscriptions`

Returns a collection of subscriptions for a customer, including selected frequency and current status of that subscription, along with a list of ids for the teas included.

#### Fields
- `customer_id` - integer (required) - ID of the customer

#### Sample Request Body
`GET /api/v1/customers/subscriptions`

```
{
    customer_id: 1
}
```

#### Sample response
```
{
    "data": [
        {
            "id": "1",
            "type": "subscriptions",
            "attributes": {
                "title": "Tea for Days",
                "price": "54.99",
                "frequency": "monthly",
                "status": "active"
            },
            "relationships": {
                "teas": {
                    "data": [
                        {
                            "id": "1",
                            "type": "tea"
                        },
                        {
                            "id": "2",
                            "type": "tea"
                        }
                    ]
                }
            }
        },
        {
            "id": "2",
            "type": "subscriptions",
            "attributes": {
                "title": "Teas for Now",
                "price": "10.99",
                "frequency": "monthly",
                "status": "cancelled"
            },
            "relationships": {
                "teas": {
                    "data": []
                }
            }
        }
    ]
}
```
