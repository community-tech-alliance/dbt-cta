{{ config(
	auto_refresh = false,
	full_refresh = false
) }}

select * from {{ source('cta','offices_addresses_base') }}
