{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

select * from {{ source('cta','question_response_base') }}
