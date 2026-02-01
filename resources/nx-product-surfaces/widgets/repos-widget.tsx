type ReposWidgetProps = {
  githubEnabled: boolean;
};

export function ReposWidget({ githubEnabled }: ReposWidgetProps) {
  if (!githubEnabled) {
    return (
      <div className="border rounded-lg p-3">
        <h3 className="text-sm font-medium">Repos</h3>
        <p className="mt-1.5 text-sm text-muted-foreground">
          Enable the GitHub integration to see repos.
        </p>
      </div>
    );
  }

  return (
    <div className="border rounded-lg p-3">
      <h3 className="text-sm font-medium">Repos</h3>
      <div className="mt-1.5">
        <p className="text-sm text-muted-foreground">
          Connect GitHub to see your repositories here.
        </p>
        <a
          href="/auth/github/start"
          className="mt-2 inline-block text-sm text-primary hover:underline"
        >
          Connect GitHub
        </a>
      </div>
    </div>
  );
}
