{{ config(full_refresh=false) }}
select *
from {{ source('cta','payments_card_details_card_base') }}