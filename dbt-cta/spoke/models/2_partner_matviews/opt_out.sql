{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

select * from {{ source('cta','opt_out_raw') }}
