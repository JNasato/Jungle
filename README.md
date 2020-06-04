# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example.

## Screenshots

!["Screenshot of products list"](https://raw.githubusercontent.com/JNasato/Jungle/master/docs/jungle_products_list.png)
!["Screenshot of cart with products to purchase"](https://raw.githubusercontent.com/JNasato/Jungle/master/docs/jungle_cart.png)
!["Screenshot of order details after order has been processed"](https://raw.githubusercontent.com/JNasato/Jungle/master/docs/jungle_order_details.png)
!["Screenshot of the products list from the admin's perspective"](https://raw.githubusercontent.com/JNasato/Jungle/master/docs/jungle_admin_all_products.png)

## Setup

1. Run `bundle install` to install dependencies
2. Create `config/database.yml` by copying `config/database.example.yml`
3. Create `config/secrets.yml` by copying `config/secrets.example.yml`
4. Run `bin/rake db:reset` to create, load and seed db
5. Create .env file based on .env.example
6. Sign up for a Stripe account
7. Put Stripe (test) keys into appropriate .env vars
8. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe