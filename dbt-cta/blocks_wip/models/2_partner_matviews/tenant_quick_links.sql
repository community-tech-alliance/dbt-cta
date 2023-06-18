
SELECT
    *
FROM {{ source('cta', 'tenant_quick_links_base') }}
;
