# External Testing Guide

This guide helps you share your running dev stack with external testers safely and quickly.

## Option A — Fastest: Share your local dev via a tunnel (today)

Prereqs:
- Your app running with Docker Compose (frontend at http://localhost:3000, backend at http://localhost:8000)
- One of these tunneling tools installed: Cloudflare Tunnel (free) or ngrok

Steps:
1) Start your stack (if not already):
   - docker compose up --build

2) Expose your frontend and backend:
   - Cloudflare Tunnel (recommended free):
     - cloudflared tunnel --url http://localhost:3000
     - cloudflared tunnel --url http://localhost:8000
   - OR ngrok:
     - ngrok http 3000
     - ngrok http 8000
   Note the two public URLs assigned (one for :3000, one for :8000).

3) Point the frontend to the public backend URL:
   - Copy `docker-compose.override.example.yml` to `docker-compose.override.yml`
   - Replace BACKEND_PUBLIC_URL with your backend tunnel URL (e.g. https://your-backend-tunnel.ngrok.io)
   - Restart the frontend so it picks up the new env:
     - docker compose up -d --force-recreate frontend

4) Share the frontend tunnel URL with testers. They will register using invite codes and the frontend will call the backend via the public URL.

Notes:
- CORS is already permissive in dev (allow_origins: ["*"]), so cross-origin via tunnel is fine.
- Data is stored in your local SQLite DB (`backend/social.db`), so you keep control during testing.

## Option B — Staging deployment (more stable)

Backend (Render.com):
- Create a new Web Service from the `backend/` folder. Use Dockerfile or Python build. Expose port 8000.
- Set start command to: uvicorn main:app --host 0.0.0.0 --port 8000
- Set env (if needed). Ensure database path is writable; default `./social.db` works on Render ephemeral disk.
- Copy the public URL (e.g. https://lemi-backend.onrender.com)

Frontend (Vercel or Netlify):
- Build from `web-frontend/`. Build command: `npm run build`, output dir: `build`
- Set env var REACT_APP_API_URL to the backend public URL
- Deploy. Share the frontend URL with testers.

CORS:
- For staging, you may tighten CORS in `backend/main.py` by listing your frontend domain in allow_origins.

## Invites and accounts
- Use Admin → Invitations to generate shareable invite codes for testers.
- Dev seed users (password `123`): Admin, Mitsu, Zine, Kat. For public staging, consider changing these passwords and/or removing seeds.

## Test plan (suggested)
- Onboarding: invite deep-link works; Sign Up with password; starter profile created; "just registered" opens profile in edit mode; subsequent visits open in view mode.
- Login/Logout: case-insensitive usernames; wrong password rejected.
- Admin:
  - Auto-Proposals: edit participants (add/remove), publish & assign.
  - Users tab: REAL/BOT badges; dynamic users visible; user detail modal shows full local profile + joined events.
  - Events: cannot delete events with any REAL participants; can remove bot-only events.
  - Invitations: create/copy/revoke; codes marked used after registration.
- Social Roulette / Requests: lists events and users; fetch fallback graceful.

## Collecting feedback
- Create a simple Google Form (link it here) so testers can report issues quickly.
- Optional: enable console log capture or add Sentry for error reporting (don’t include secrets).

## Safety checklist before sharing
- [ ] Frontend points to the right backend URL (REACT_APP_API_URL)
- [ ] Two public tunnel URLs created (or staging deployed)
- [ ] Enough invite codes generated
- [ ] Test a full flow yourself using the public URLs
- [ ] Communicate a cut-off time; close tunnels when done
