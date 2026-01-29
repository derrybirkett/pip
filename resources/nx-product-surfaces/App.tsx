import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { useState } from 'react';
import { useAuthSession } from '../auth/auth-session';
import { useIntegrationSettings } from '../integrations/use-integration-settings';
import { ReposWidget } from '../widgets/repos-widget';

export function App() {
  const { session, isLoading, signIn, signOut } = useAuthSession();
  const [email, setEmail] = useState('');
  const [menuOpen, setMenuOpen] = useState(false);
  const { settings, setGithubEnabled } = useIntegrationSettings();

  if (isLoading) {
    return null;
  }

  if (!session?.user) {
    return (
      <div className="min-h-screen p-6">
        <div className="max-w-lg mx-auto mt-[10vh] flex flex-col gap-3">
          <header className="flex items-baseline justify-between">
            <h1 className="text-xl font-semibold">Sign in</h1>
          </header>

          <form
            className="flex flex-col gap-3"
            onSubmit={async (e) => {
              e.preventDefault();
              await signIn({ email });
            }}
          >
            <label className="flex flex-col gap-1.5">
              <span className="text-sm font-medium">Email</span>
              <Input
                value={email}
                onChange={(e) => setEmail(e.currentTarget.value)}
                autoComplete="email"
                placeholder="you@example.com"
              />
            </label>

            <Button type="submit">
              Sign in
            </Button>
          </form>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen">
      <header className="flex items-center justify-between gap-3 p-4 border-b">
        <div className="font-semibold">basestation</div>

        <div className="relative flex items-center">
          <Button
            variant="outline"
            size="sm"
            type="button"
            aria-haspopup="menu"
            aria-expanded={menuOpen}
            onClick={() => setMenuOpen((open) => !open)}
          >
            {session.user.email ?? 'Account'}
          </Button>

          {menuOpen ? (
            <div className="absolute top-full right-0 mt-2 min-w-[180px] rounded-lg border bg-card shadow-lg p-1.5 flex flex-col gap-1.5 z-10" role="menu">
              <Button
                variant="ghost"
                size="sm"
                className="justify-start"
                type="button"
                role="menuitem"
                onClick={() => setMenuOpen(false)}
              >
                Profile
              </Button>
              <Button
                variant="ghost"
                size="sm"
                className="justify-start"
                type="button"
                role="menuitem"
                onClick={() => setMenuOpen(false)}
              >
                Settings
              </Button>
              <Button
                variant="ghost"
                size="sm"
                className="justify-start"
                type="button"
                role="menuitem"
                onClick={async () => {
                  setMenuOpen(false);
                  await signOut();
                  window.location.href = 'http://127.0.0.1:4201/';
                }}
              >
                Logout
              </Button>
            </div>
          ) : null}
        </div>
      </header>

      <div className="grid grid-cols-1 md:grid-cols-[3fr_1fr] gap-4 p-4">
        <section className="min-w-0 flex flex-col gap-3" aria-label="Chat">
          <header className="flex items-baseline justify-between min-h-8">
            <h1 className="text-base font-medium">Chat</h1>
          </header>

          <div className="flex-1 min-h-0 flex">
            <div className="m-auto max-w-[52ch] text-center">
              <p className="font-semibold">No messages yet</p>
              <p className="mt-2 text-muted-foreground">
                Ask basestation anything about your accounts and data.
              </p>
            </div>
          </div>

          <form
            className="grid grid-cols-[1fr_auto] gap-2 items-center"
            onSubmit={(e) => e.preventDefault()}
          >
            <Input
              aria-label="Message"
              placeholder="Message…"
            />
            <Button type="submit">
              Send
            </Button>
          </form>
        </section>

        <section className="min-w-0 flex flex-col gap-3" aria-label="Widgets">
          <header className="flex items-baseline justify-between min-h-8">
            <h2 className="text-base font-medium">Widgets</h2>
          </header>

          <div className="flex flex-col gap-3">
            <div className="border rounded-lg p-3">
              <h3 className="text-sm font-medium">Marketplace</h3>
              <div className="mt-1.5">
                <div className="flex items-start justify-between gap-3">
                  <div className="min-w-0">
                    <div className="font-semibold">GitHub</div>
                    <div className="mt-1 text-sm text-muted-foreground">
                      Connect repos and activity.
                    </div>
                  </div>

                  <label className="inline-flex items-center gap-2 select-none">
                    <input
                      className="w-4 h-4"
                      type="checkbox"
                      checked={settings.github.enabled}
                      onChange={(e) => setGithubEnabled(e.currentTarget.checked)}
                      aria-label="Enable GitHub integration"
                    />
                    <span className="whitespace-nowrap text-sm">
                      {settings.github.enabled ? 'Enabled' : 'Disabled'}
                    </span>
                  </label>
                </div>
              </div>
            </div>

            <ReposWidget githubEnabled={settings.github.enabled} />
          </div>
        </section>
      </div>
    </div>
  );
}

export default App;
