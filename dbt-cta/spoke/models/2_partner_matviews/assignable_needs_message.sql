{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

select * from {{ source('cta','assignable_needs_message_base') }}
