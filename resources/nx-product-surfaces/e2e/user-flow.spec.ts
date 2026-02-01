import { test, expect } from '@playwright/test';

/**
 * Complete user flow E2E test:
 * 1. Marketing page loads
 * 2. Navigate to login
 * 3. Sign in with email
 * 4. App dashboard renders
 * 5. Open user dropdown menu
 * 6. Logout
 * 7. Redirect back to marketing page
 */

test.describe('Complete User Flow', () => {
  test('should complete full user journey from marketing to app and back', async ({ page }) => {
    // 1. Marketing page loads
    await page.goto('http://localhost:4201');
    await expect(page).toHaveTitle(/Marketing/i);
    
    // Verify marketing page loaded successfully
    await expect(page.locator('body')).toBeVisible();

    // 2. Navigate to login (app page)
    await page.goto('http://localhost:4200');
    
    // 3. Sign in with email
    // Wait for sign-in form to appear
    await expect(page.getByRole('heading', { name: /sign in/i })).toBeVisible();
    
    // Fill in email field
    const emailInput = page.getByPlaceholder(/you@example\.com/i);
    await emailInput.fill('test@example.com');
    
    // Submit form
    const signInButton = page.getByRole('button', { name: /sign in/i });
    await signInButton.click();
    
    // 4. App dashboard renders
    // Wait for authenticated state - check for user menu button with email
    await expect(page.getByRole('button', { name: /test@example\.com|account/i })).toBeVisible({ timeout: 10000 });
    
    // Verify main sections are present
    await expect(page.getByRole('region', { name: /chat/i })).toBeVisible();
    await expect(page.getByRole('region', { name: /widgets/i })).toBeVisible();
    
    // Verify placeholder content
    await expect(page.getByText(/no messages yet/i)).toBeVisible();
    
    // 5. Open user dropdown menu
    const userMenuButton = page.getByRole('button', { name: /test@example\.com|account/i });
    await userMenuButton.click();
    
    // Verify menu is open
    const menuDropdown = page.getByRole('menu');
    await expect(menuDropdown).toBeVisible();
    
    // Verify menu items
    await expect(page.getByRole('menuitem', { name: /profile/i })).toBeVisible();
    await expect(page.getByRole('menuitem', { name: /settings/i })).toBeVisible();
    await expect(page.getByRole('menuitem', { name: /logout/i })).toBeVisible();
    
    // 6. Logout
    const logoutButton = page.getByRole('menuitem', { name: /logout/i });
    await logoutButton.click();
    
    // 7. Verify redirect back to sign-in page or marketing
    // The app should show the sign-in form again
    await expect(page.getByRole('heading', { name: /sign in/i })).toBeVisible({ timeout: 5000 });
  });

  test('should toggle GitHub integration setting', async ({ page }) => {
    // Navigate to app and sign in
    await page.goto('http://localhost:4200');
    
    await page.getByPlaceholder(/you@example\.com/i).fill('test@example.com');
    await page.getByRole('button', { name: /sign in/i }).click();
    
    // Wait for dashboard
    await expect(page.getByRole('region', { name: /widgets/i })).toBeVisible({ timeout: 10000 });
    
    // Find GitHub integration toggle
    const githubToggle = page.getByRole('checkbox', { name: /enable github integration/i });
    await expect(githubToggle).toBeVisible();
    
    // Get initial state
    const initialState = await githubToggle.isChecked();
    
    // Toggle it
    await githubToggle.click();
    
    // Verify state changed
    await expect(githubToggle).toBeChecked({ checked: !initialState });
    
    // Verify the label updated
    const expectedLabel = initialState ? /disabled/i : /enabled/i;
    await expect(page.getByText(expectedLabel)).toBeVisible();
  });

  test('should display ReposWidget based on GitHub integration', async ({ page }) => {
    // Navigate to app and sign in
    await page.goto('http://localhost:4200');
    
    await page.getByPlaceholder(/you@example\.com/i).fill('test@example.com');
    await page.getByRole('button', { name: /sign in/i }).click();
    
    // Wait for dashboard
    await expect(page.getByRole('region', { name: /widgets/i })).toBeVisible({ timeout: 10000 });
    
    // Verify Repos widget is present
    await expect(page.getByText(/repos/i).first()).toBeVisible();
    
    // Check initial message (integration disabled)
    const githubToggle = page.getByRole('checkbox', { name: /enable github integration/i });
    const isEnabled = await githubToggle.isChecked();
    
    if (!isEnabled) {
      await expect(page.getByText(/enable the github integration/i)).toBeVisible();
    }
    
    // Enable integration
    if (!isEnabled) {
      await githubToggle.click();
    }
    
    // Verify connect link appears
    await expect(page.getByRole('link', { name: /connect github/i })).toBeVisible();
  });
});
