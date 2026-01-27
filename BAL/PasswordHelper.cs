using System;
using System.Security.Cryptography;
using System.Text;

public static class PasswordHelper
{
    private const string FixedSalt = "MyApp@2026!#FixedSalt";

    public static string HashPasswordSHA256(string password)
    {
        string saltedPassword = password + FixedSalt;

        using (SHA256 sha = SHA256.Create())
        {
            byte[] hashBytes = sha.ComputeHash(
                Encoding.UTF8.GetBytes(saltedPassword));

            return Convert.ToBase64String(hashBytes);
        }
    }

    private const int SaltSize = 16;
    private const int KeySize = 32;
    private const int Iterations = 10000;

    public static string HashPassword(string password)
    {
        using (var rng = RandomNumberGenerator.Create())
        {
            byte[] salt = new byte[SaltSize];
            rng.GetBytes(salt);

            using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, Iterations))
            {
                byte[] key = pbkdf2.GetBytes(KeySize);
                return $"{Iterations}.{Convert.ToBase64String(salt)}.{Convert.ToBase64String(key)}";
            }
        }
    }

    public static bool VerifyPassword(string password, string hashedPassword)
    {
        var parts = hashedPassword.Split('.');
        if (parts.Length != 3)
            return false;

        int iterations = int.Parse(parts[0]);
        byte[] salt = Convert.FromBase64String(parts[1]);
        byte[] storedKey = Convert.FromBase64String(parts[2]);

        using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, iterations))
        {
            byte[] computedKey = pbkdf2.GetBytes(storedKey.Length);
            return FixedTimeEquals(storedKey, computedKey);
        }
    }

    // Constant-time comparison (safe for old .NET / Mono)
    private static bool FixedTimeEquals(byte[] a, byte[] b)
    {
        if (a.Length != b.Length)
            return false;

        int diff = 0;
        for (int i = 0; i < a.Length; i++)
        {
            diff |= a[i] ^ b[i];
        }
        return diff == 0;
    }
}
