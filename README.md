# Experts Legal Consultation V1

Cross-platform Flutter starter for **EXPERTS FOR COLLECTION ATTORNEY & AGENCIES**.

Included in this first working prototype:
- Navy + gold branding using the exact prior project logo.
- Splash screen.
- Login.
- Company registration with company logo selection.
- Pending admin approval state.
- Approved client home dashboard.
- Legal consultation form with topic, description and document picker.
- Consultation history/detail/reply UI.
- Appointment request screen.
- Admin dashboard prototype.
- Client consultation reports: week, month, year and total.

## Important
This V1 deliberately uses an in-memory demo repository so the full screen flow can be tested before connecting production authentication, database, file storage and push notifications.

Demo credentials:
- Admin: `admin` / `admin123`
- Approved client: `client` / `client123`
- Pending client: `pending` / `pending123`

## Run
1. Install Flutter stable.
2. From this folder run `flutter create .` once to generate Android/iOS host folders if needed.
3. Run `flutter pub get`.
4. Run `flutter run`.

For store production, backend/auth/storage and signing will be connected in the next implementation stage.

## V2 Concept UI
UI revised to closely follow the approved navy/gold concept: gold-gradient controls, client hero banner, white service cards, bottom client navigation, and richer admin dashboard.
