
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Zooshop.Data;

namespace Zooshop
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            builder.Services.AddCors(options =>
            {
                // ��������� ����������� �������� CORS � ��������� "AllowAngular".
                options.AddPolicy("AllowAngular", policy =>
                {
                    // ��������� ������� ������ � ���������� ���������: http://localhost:4200.
                    policy.WithOrigins("http://localhost:60610")
                        // ��������� ����� HTTP-������ (GET, POST, PUT, DELETE � �.�.).
                        .AllowAnyMethod()
                        // ��������� ����� ��������� � �������� (��������, Content-Type, Authorization).
                        .AllowAnyHeader()
                        // ��������� �������� ������� ������ (��������, cookies, HTTP-��������������).
                        .AllowCredentials();
                });
            });

            var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
            connectionString = connectionString.Replace("|DataDirectory|", AppDomain.CurrentDomain.BaseDirectory);

            builder.Services.AddDbContext<AppDbContext>(options =>
                options.UseSqlite(connectionString));

            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();

            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseAuthorization();

            app.UseCors("AllowAngular");

            app.MapControllers();

            app.Run();
        }
    }
}
