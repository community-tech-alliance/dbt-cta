{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

select * from {{ source('cta','zip_code_base') }}
