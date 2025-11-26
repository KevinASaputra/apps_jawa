export const tokenBlackList = new Map<string, number>();

export function blacklistToken(token: string, exp: number) {
  tokenBlackList.set(token, exp * 1000);
}


export function isBlacklisted(token: string): boolean {
  const exp = tokenBlackList.get(token);
  if (!exp) return false;

  if (Date.now() > exp) {
    tokenBlackList.delete(token);
    return false;
  }

  return true;
}