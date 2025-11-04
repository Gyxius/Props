# Staging Deployment Guide

This sets up a cloud-hosted backend and frontend so external testers can use your app without relying on your machine.

## Overview
- Backend: Render (FastAPI + SQLite)
- Frontend: Vercel or Netlify (Create React App static build)
- Config: Frontend points to backend via `REACT_APP_API_URL`.
- CORS: Backend allows only your staging frontend domain (configurable via env).

---

## 1) Backend on Render

Option A — Docker (recommended for consistency)
1. In the Render dashboard, create a New Web Service.
2. Choose “Build and deploy from a Git repository” and select this repo.
3. In the service settings:
   - Environment: Docker
   - Root Directory: repository root
   - Dockerfile path: `backend/Dockerfile.render`
   - Auto Deploy: Yes
4. Environment Variables:
   - `PYTHONUNBUFFERED=1`
   - `FRONTEND_ORIGINS=https://YOUR_FRONTEND_DOMAIN`  (comma-separated if multiple)
5. Health check path (optional): `/users`
6. Create the service and deploy. Render will detect port 8000 from the Dockerfile.

Option B — Native Python service (no Docker)
- Build Command: `pip install -r requirements.txt`
- Start Command: `uvicorn main:app --host 0.0.0.0 --port 8000`
- Root Directory: `backend/`
- Env Vars: same as above.

Note on data: SQLite (`./social.db`) will live on Render’s disk. For casual testing this is fine. For persistent staging, consider moving to a managed DB.

---

## 2) Frontend on Vercel
1. Import the repo in Vercel, choose the `web-frontend/` directory.
2. Build Command: `npm run build`
3. Output Directory: `build`
4. Environment Variables (Production):
   - `REACT_APP_API_URL=https://YOUR_RENDER_BACKEND.onrender.com`
5. Deploy. Share the resulting Vercel URL with testers.

SPA routing: Vercel handles CRA well by serving `index.html` for client routes automatically.

---

## 3) Frontend on Netlify (alternative)
1. New site from Git, choose `web-frontend/`.
2. Build Command: `npm run build`
3. Publish directory: `build`
4. Env Var: `REACT_APP_API_URL=https://YOUR_RENDER_BACKEND.onrender.com`
5. Ensure SPA fallback works — we added `public/_redirects` with:
   ```
   /*  /index.html  200
   ```

---

## 4) Configure CORS for staging
We updated the backend to read allowed origins from env variables. On Render, set:
- `FRONTEND_ORIGINS=https://your-frontend.vercel.app` (or your Netlify domain)

If unset, dev default is `*`.

---

## 5) Sanity checklist
- Backend is live at Render URL (try GET `/users`).
- Frontend builds and points to correct backend via `REACT_APP_API_URL`.
- Backend CORS is restricted to your staging frontend domain.
- Invite codes created and shared.
- Try full flow on staging: deep-linked invite → Sign Up → first-time profile edit → normal login.

---

## 6) Optional hardening for public staging
- Remove or change seed credentials (Admin, Mitsu, Zine, Kat all `123`).
- Add basic rate limiting for `/login`.
- Move invites server-side (enforce on `/register`).
- Add a basic status page or health endpoint.
