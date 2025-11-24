# Lemi Guide Feature

## Overview
The Lemi Guide is an admin-only feature designed to help international students navigate complex French visa and residence permit renewal processes. It provides a comprehensive dashboard with step-by-step guidance, progress tracking, and deadline management.

## Branch Information
- **Feature Branch**: `feature/lemi-guide`
- **Web Frontend Branch**: `feature/lemi-guide`
- **Status**: ✅ Implemented, ready for testing

## Feature Access
- **Visibility**: Admin users only
- **Access Path**: Profile Avatar → My Account → Lemi Guide button
- **Admin Detection**: Username === "admin" or name === "Admin"

## Components Created

### 1. LemiGuide.js
**Location**: `web-frontend/src/LemiGuide.js`

**Purpose**: Main dashboard component for visa/residence permit guidance

**Key Features**:
- **Progress Bar**: Visual progress tracking (e.g., 3/16 steps, 19% complete)
- **Welcome Card**: Personalized greeting with current status
- **Critical Deadline Warning**: Yellow alert box with days remaining
- **Metrics Panel**: 3-column grid showing:
  - Steps Done (green)
  - Steps Left (orange)
  - Days Left (red)
- **Next Action Card**: Highlighted current task with description and CTA button
- **Task List**: Complete 16-step checklist for VLS-TS residence permit renewal

**Sample User Context** (VLS-TS Residence Permit Renewal):
```javascript
{
  appStatus: "Lemi Guide",
  userStatus: "Renewing VLS-TS Residence Permit (Non-EU Student)",
  location: "Paris, Île-de-France",
  totalSteps: 16,
  stepsCompleted: 3,
  criticalDeadline: "2026-03-15",
  daysRemaining: 75
}
```

**16 Steps Included**:
1. ✅ Schedule Your Prefecture Appointment
2. ✅ Gather Required Documents
3. ✅ Get Your Passport Photos
4. 🔄 Obtain Proof of Residence (in-progress)
5. ⏳ Request Your Student Certificate
6. ⏳ Prepare Financial Documents
7. ⏳ Fill Out the Application Form
8. ⏳ Pay the Application Fee (€225)
9. ⏳ Make Document Copies
10. ⏳ Attend Prefecture Appointment
11. ⏳ Submit Biometric Data
12. ⏳ Receive Receipt (Récépissé)
13. ⏳ Wait for Processing (2-3 months)
14. ⏳ Receive Notification
15. ⏳ Pick Up Your Residence Permit
16. ⏳ Activate Your Permit Online

**Design Principles**:
- ✨ Empathetic and encouraging tone
- 📱 Mobile-first responsive design
- 🎨 Clean card-based UI with Lemi Paris brand colors
- 🌍 Simple English, minimal French jargon
- ✅ Clear status indicators (icons + colors)

### 2. NotificationsInbox.js (Modified)
**Changes**:
- Added `onOpenLemiGuide` and `onOpenAdminDashboard` props
- Added admin-only button section between "Past Events" and "Sign Out"
- Admin buttons only render when `currentUser.username === "admin"` or `currentUser.name === "Admin"`

**New Buttons**:
1. 🎛️ **Admin Dashboard** (orange) - Placeholder for future admin panel
2. 🧭 **Lemi Guide** (green) - Opens visa assistance dashboard

### 3. SocialHome.js (Modified)
**Changes**:
- Imported `LemiGuide` component
- Added `showLemiGuide` state variable
- Passed `onOpenLemiGuide` and `onOpenAdminDashboard` callbacks to `NotificationsInbox`
- Rendered `LemiGuide` modal at end of component

**Admin Dashboard Callback**:
```javascript
onOpenAdminDashboard={() => {
  alert("Admin Dashboard feature coming soon!");
}}
```

**Lemi Guide Callback**:
```javascript
onOpenLemiGuide={() => setShowLemiGuide(true)}
```

## User Flow

### For Admin Users:
1. Click **Profile Avatar** (top-left of header)
2. See "My Account" modal open
3. Scroll to admin section (below regular profile buttons)
4. See two new buttons:
   - 🎛️ **Admin Dashboard** (coming soon)
   - 🧭 **Lemi Guide** (functional)
5. Click **Lemi Guide** button
6. Dashboard opens showing:
   - Header with progress bar
   - Welcome card with status
   - Critical deadline warning
   - Metrics panel
   - Next action card
   - Full 16-step task list
7. Click **X** or outside modal to close

### For Non-Admin Users:
- Admin buttons are completely hidden
- No access to Lemi Guide or Admin Dashboard

## Visual Design

### Color Palette:
- **Background**: `#F7F7F5` (light warm gray)
- **Cards**: `#FFFFFF` (white)
- **Primary Green**: `#58CC02` (Lemi brand)
- **Primary Dark**: `#37B300`
- **Warning Orange**: `#F59E0B`
- **Success Green**: `#10B981`
- **Danger Red**: `#EA2B2B`

### Typography:
- **Header**: 24px, bold 900
- **Section Titles**: 18px, bold 900
- **Body Text**: 14px, regular 400
- **Metrics**: 28px, bold 900

### Status Colors:
- ✅ **Completed**: Green (`#10B981`)
- 🔄 **In Progress**: Orange (`#F59E0B`)
- ⏳ **Pending**: Gray (`#6B7280`)

## Technical Implementation

### State Management:
```javascript
const [showLemiGuide, setShowLemiGuide] = useState(false);
```

### Modal Pattern:
- Fixed overlay with semi-transparent background
- Centered card with scroll overflow
- Click outside to close
- X button in header to close

### Responsive Design:
- Max width: 600px
- Mobile padding: 20px
- Card border radius: 16px
- Auto-scrolling content area

## Testing Checklist

### Functional Tests:
- [ ] Admin user sees Lemi Guide button in profile menu
- [ ] Non-admin user does NOT see Lemi Guide button
- [ ] Lemi Guide opens when button clicked
- [ ] Modal closes on X button click
- [ ] Modal closes on outside click
- [ ] Progress bar shows correct percentage (19%)
- [ ] Metrics display correct numbers (3 done, 13 left, 75 days)
- [ ] Task list shows 16 items
- [ ] Task statuses display correctly (completed/in-progress/pending)
- [ ] Next action card highlights step 4
- [ ] "Start This Step" button is clickable

### Visual Tests:
- [ ] Mobile responsive (320px - 428px width)
- [ ] Tablet responsive (768px - 1024px width)
- [ ] Desktop responsive (1280px+)
- [ ] Colors match brand palette
- [ ] Icons display correctly (emoji support)
- [ ] Cards have proper shadows and spacing
- [ ] Text is readable and well-spaced
- [ ] Progress bar animates smoothly

### UX Tests:
- [ ] Tone is empathetic and encouraging
- [ ] Steps are clearly explained
- [ ] Deadline warning is prominent
- [ ] Next action is obvious
- [ ] Navigation is intuitive
- [ ] Loading states handled gracefully

## Future Enhancements

### Phase 2:
- [ ] Dynamic user data from backend API
- [ ] Editable user status
- [ ] Custom deadline input
- [ ] Step completion toggling
- [ ] Document upload functionality
- [ ] Reminder notifications

### Phase 3:
- [ ] Multiple visa types support
- [ ] Multi-language support (French, English, Spanish)
- [ ] PDF checklist export
- [ ] Progress sharing with friends
- [ ] Admin Dashboard implementation

### Phase 4:
- [ ] AI-powered guidance (GPT integration)
- [ ] Document verification
- [ ] Appointment scheduling integration
- [ ] Prefecture wait time tracking
- [ ] Success stories and tips from alumni

## Deployment

### To Test Locally:
```bash
cd /Users/mitsou/Desktop/Props/web-frontend
git checkout feature/lemi-guide
npm install
npm start
```

### To Merge to Main:
```bash
# In web-frontend submodule
git checkout main
git merge feature/lemi-guide
git push origin main

# In main Props repo
cd /Users/mitsou/Desktop/Props
git add web-frontend
git commit -m "Update web-frontend with Lemi Guide feature"
git push origin main
```

### Netlify Deployment:
- Netlify auto-deploys from main branch
- Preview: Build and deploy from `feature/lemi-guide` branch for testing

## Notes

### Why Admin-Only?
The Lemi Guide is currently admin-only because:
1. Feature is experimental and needs admin testing first
2. User data structure not yet defined in backend
3. Prevents overwhelming regular users during beta phase
4. Allows admins to dogfood and provide feedback

### Why Hardcoded Data?
The component uses sample data for VLS-TS renewal because:
1. Backend API endpoints not yet created
2. User profile schema doesn't include visa status
3. Faster iteration during UI/UX design phase
4. Real data will be integrated in Phase 2

### Design Inspiration:
- Duolingo's gamified progress tracking
- Notion's clean card-based layouts
- Government service journeys (GOV.UK, France Connect)
- Todoist's task management clarity

## Support

For questions or issues:
- GitHub Issues: [Your Repo URL]
- Email: [Your Email]
- Lemi Paris Discord: [Discord Link]

---

**Created**: November 24, 2025  
**Last Updated**: November 24, 2025  
**Version**: 1.0.0  
**Status**: ✅ Ready for Testing
