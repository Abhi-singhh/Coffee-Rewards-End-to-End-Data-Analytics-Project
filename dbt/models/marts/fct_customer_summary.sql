-- Mart model: one row per customer, summarizing spend and rewards
-- from the cleaned event stream. Powers the "high-value loyalty
-- customers" ranking from the original analysis.

with events as (
    select * from {{ ref('stg_events') }}
)

select
    customer_id,
    sum(amount) as total_spent,
    sum(reward) as total_rewards,
    rank() over (order by sum(amount) desc) as spend_rank
from events
group by customer_id
