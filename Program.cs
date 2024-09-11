using Microsoft.EntityFrameworkCore;
using PEDIDOS_APIREST.Data;

var builder = WebApplication.CreateBuilder(args);

//Configuracion  de contexto de base de datos
builder.Services.AddDbContext<DbpedidosContext>(options =>
        options.UseSqlServer(builder.Configuration.GetConnectionString("conexionBD") ??
        throw new InvalidOperationException("No se ha encontrado cadena de conexion")));



// Add services to the container.
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
