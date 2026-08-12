-- Staging model: parses the raw events.value column (a JSON-like string)
-- into three clean columns: offer_id, amount, reward.
-- Rewritten to use REGEXP_EXTRACT instead of manual substring offset math —
-- the original SQLite version relied on fragile position math that produced
-- trailing characters (e.g. "5}") for single-digit rewards. SQLite's lenient
-- CAST() silently truncated these; BigQuery's strict CAST() correctly
-- rejected them, surfacing the bug.

with source as (
    select * from {{ ref('events') }}
)

select
    customer_id,
    event,
    time,
    regexp_extract(value, r"offer[_ ]id':\s*'([a-zA-Z0-9]+)'") as offer_id,
    cast(regexp_extract(value, r"'amount':\s*([0-9.]+)") as float64) as amount,
    cast(regexp_extract(value, r"'reward':\s*([0-9.]+)") as float64) as reward
from source
