# QA Checklist for Staging

Use these to validate core flows before inviting more testers.

## Onboarding & Auth
- [ ] Invite deep-link auto-fills and switches to Sign Up
- [ ] Registration requires valid invite code
- [ ] Password is required and stored/verified server-side
- [ ] Case-insensitive usernames work on login
- [ ] Wrong password rejected with clear error
- [ ] First visit after registration opens My Profile in edit mode; later opens in view mode

## Admin Dashboard
- [ ] Auto-Proposals: admin can add/remove participants
- [ ] Can view participant details and navigate to full user modal
- [ ] Publish & Assign proposal works without errors
- [ ] Users tab shows REAL/BOT badges and dynamic users (local profiles)
- [ ] Clicking a user shows full profile + joined events
- [ ] Events with any REAL participants cannot be deleted; bot-only events can
- [ ] Invitations: can create/copy/revoke codes; codes marked used after registration

## Social & Data Fetching
- [ ] Events list loads from backend
- [ ] Users list loads from backend
- [ ] Graceful fallback if backend unavailable (UI remains usable)

## UX & Polish
- [ ] Switching Login <-> Sign Up clears password; Sign Up clears username
- [ ] Browser autofill minimized on Sign Up
- [ ] No sensitive data persists in forms after logout

## Safety
- [ ] Backend CORS limited to staging frontend domain
- [ ] Seed accounts updated/disabled for public staging (Admin, Mitsu, Zine, Kat)
- [ ] Invite codes generated for testers (enough supply)

## Optional Next
- [ ] Server-side invite enforcement on /register
- [ ] Password change/reset flows
- [ ] Rate limiting for /login
- [ ] Error tracking (Sentry) and feedback link
