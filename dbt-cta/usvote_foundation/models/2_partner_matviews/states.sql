{{ config(
	auto_refresh = false,
	full_refresh = false
) }}

select * from {{ source('cta','states_base') }}
