
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','team_member_wages_base') }}
  