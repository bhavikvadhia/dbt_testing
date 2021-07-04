with orders as (

    select * from {{ ref('stg_orders') }}

),
payments as (

    select order_id,sum(amount) as ord_amt
      from {{ ref('stg_payments') }}
     where status = 'success'
     group by order_id
)
,
final as (

    select ord.order_id
           ,ord.customer_id
           ,pymnt.ord_amt
      from orders ord
      left join payments pymnt
        on ord.order_id = pymnt.order_id
)

select * from final