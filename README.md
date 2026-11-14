# Timber Joints CRM

Mobile-first CRM for Timber Joints, a custom sofa and seating business in Bengaluru, India.

## Features
- Email magic-link sign-in
- Customer and sofa order records
- Production stages: Enquiry, Confirmed, Frame, Foam, Stitching, Upholstery, Ready for delivery, Delivered
- Advance and balance payment tracking
- Dashboard summaries, search and CSV export
- Supabase Postgres storage with per-user Row Level Security

## Supabase setup
1. Open the Supabase project SQL Editor.
2. Run the complete SQL in [supabase/schema.sql](supabase/schema.sql).
3. Confirm the `orders` table exists and Row Level Security is enabled.
4. In Authentication settings, ensure email sign-in is enabled and add your deployed CRM URL to the allowed redirect URLs.
5. Deploy the site over HTTPS. The browser app uses the Supabase project URL and publishable key in `index.html`; never put a secret/service-role key in browser code.

## Important
- Do not enter real customer records until the SQL has run and you have verified sign-in and access.
- Existing browser-local prototype records are not automatically migrated.
- The publishable key is intended for browser use only when RLS policies are correctly configured.
- Supabase free-tier limits apply; check current plan quotas and backup options before relying on it for business-critical records.

Currency: INR (₹).
