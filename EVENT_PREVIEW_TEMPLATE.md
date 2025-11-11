# Event Preview UI/UX Template

> **Purpose**: Single event preview page for non-joined events  
> **Goal**: High scannability, strong visual hierarchy, maximum conversion  
> **Architecture**: React component with 4 distinct sections

---

## Component 1: Header Block
*Focus: High-level logistics & Host credibility*

### Event Title
# KARAOKE NIGHT

### Host Section (Prominent positioning near title)
**👤 HOSTED BY**  
**admin**

### Logistics Bar (Scannable list with visual hierarchy)
📅 **2025-11-12 at 22:30**  
⏰ **10:30 PM – 2:00 AM**  
📍 **Paris**  
**Le Fleurus**  
*Le Fleurus, 10, Boulevard Jourdan, Quartier du Parc-de-Montsouris, Paris 14e Arrondissement, Paris, Île-de-France, France métropolitaine, 75014, France*

🍺 🍹 **drinks**

---

## Component 2: Description Block
*Focus: Content scannability & engagement*

### Section Header
**📝 ABOUT THIS EVENT**

### Key Activities (Bulleted format for quick scanning)
**🎤🎶 KARAOKE NIGHT – WEDNESDAY, NOV 12 🎶🎤**

Ready to grab the mic again? It's time for another Karaoke Night at Fleurus! 🎉

- ⏰ **10:30 PM – 2:00 AM**
- 📍 **Fleurus Bar**
- 🎤 **Sing solo, duet, or cheer for your friends!**
- 🥳 **Chill vibes, good music, and lots of laughs guaranteed.**

### Social/Vibe Description (Concluding paragraph)
Come have fun, meet new people, and enjoy a mid-week break with the Cité crowd! 💛

**No sign-up needed — just show up and bring your voice (and confidence 😎).**

---

## Component 3: Participants Block
*Focus: Social proof & FOMO*

### Section Header
**👥 PARTICIPANTS (2)**

### Visual Participant Display
> **Design Note**: Use profile pictures/avatars in a horizontal row  
> Names are secondary to visual presence

[Avatar] **admin**  
[Avatar] **mitsou**

### All Participants Link
*View all attendees →*

---

## Component 4: CTA Block (Sticky Footer)
*Focus: Actionability & conversion flow*

### Design Specifications
- **Position**: Sticky footer, always visible
- **Layout**: Two-button horizontal layout with clear hierarchy
- **Shadow**: Elevated shadow for prominence

### Primary Action (Dominant visual weight)
```
┌──────────────────────────────────────┐
│   🎉 Join This Event                 │
│   [Full-width, gradient background]  │
│   [Large padding: 16px]              │
│   [Font: Bold 900, Size: 16px]      │
└──────────────────────────────────────┘
```
**Style Properties**:
- Background: `linear-gradient(135deg, #58CC02, #37B300)`
- Color: `white`
- Box Shadow: `0 6px 16px rgba(88,204,2,0.28)`
- Border Radius: `14px`
- Font Weight: `900`

### Secondary Action (Less prominent but discoverable)
```
┌──────────────────────────────────────┐
│   ✨ Create Your Own Event           │
│   [Full-width, purple gradient]      │
│   [Padding: 16px]                    │
│   [Font: Bold 900, Size: 16px]      │
└──────────────────────────────────────┘
```
**Style Properties**:
- Background: `linear-gradient(135deg, #667eea, #764ba2)`
- Color: `white`
- Box Shadow: `0 6px 16px rgba(102,126,234,0.28)`
- Border Radius: `14px`
- Font Weight: `900`

### Utility Actions (Top-right corner)
**← Back to Events** (Top-left)  
**🔗 Share** (Top-right, replaces "Close" button)

---

## Visual Hierarchy Summary

### Critical Path (User eye flow)
1. **Title** (Largest text, immediate attention)
2. **Host Badge** (Trust signal, near title)
3. **Logistics** (Quick scan: Date/Time/Location)
4. **Description Bullets** (Key activities)
5. **Participants Count** (Social proof)
6. **Primary CTA** (Join button, sticky footer)

### Typography Scale
- **Event Title**: 28px, Weight 900
- **Section Headers**: 13px, Weight 800, UPPERCASE, Letter-spacing 0.5px
- **Body Content**: 15px, Weight 400, Line-height 1.6
- **CTA Buttons**: 16px, Weight 900
- **Metadata**: 15px, Weight 400

### Color Palette
- **Primary Green**: `#58CC02` → `#37B300` (gradient)
- **Secondary Purple**: `#667eea` → `#764ba2` (gradient)
- **Text Primary**: `#1F2937`
- **Text Muted**: `#6B7280`
- **Background**: `#FFFFFF`
- **Background Light**: `#F7F7F5`

### Spacing & Layout
- **Component Padding**: 24px mobile, 32px desktop
- **Section Margin Bottom**: 16-20px
- **Element Gap**: 8-12px
- **Border Radius**: 12-18px (cards/buttons)

---

## Implementation Notes

### React Component Architecture
```
EventPreviewModal
├── Header
│   ├── BackButton
│   ├── EventTitle
│   └── ShareButton
├── HeroSection
│   ├── EventBanner (optional)
│   └── HostBadge
├── LogisticsBar
│   ├── DateTimeInfo
│   ├── LocationInfo
│   └── CategoryBadge
├── DescriptionBlock
│   ├── SectionHeader
│   ├── BulletList
│   └── SocialContext
├── ParticipantsBlock
│   ├── SectionHeader
│   ├── AvatarGrid
│   └── ViewAllLink
└── CTAFooter (Sticky)
    ├── JoinButton (Primary)
    └── CreateOwnButton (Secondary)
```

### Accessibility Requirements
- All emojis should have `aria-label` attributes
- Buttons must have `:focus` states
- Content must be keyboard navigable
- Minimum touch target: 44x44px for mobile

### Responsive Breakpoints
- **Mobile**: < 768px (single column, smaller padding)
- **Tablet**: 768px - 1024px (increased padding)
- **Desktop**: > 1024px (max-width 600px, centered)

---

## Key UX Principles Applied

1. **Scannability**: Visual hierarchy with emojis, bold text, and whitespace
2. **Social Proof**: Participants section with avatars (not just names)
3. **Clear Actions**: Sticky footer ensures CTA is always visible
4. **Progressive Disclosure**: Key info first, details below
5. **Trust Building**: Host prominence and participant count
6. **Low Friction**: Single-click join, no forms in preview
7. **Secondary Path**: "Create Your Own" for template inspiration
8. **Exit Strategy**: Back button (not "Close") for clearer navigation

---

**Template Version**: 1.0  
**Last Updated**: November 10, 2025  
**Status**: Ready for implementation
