
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','team_members_base') }}
  