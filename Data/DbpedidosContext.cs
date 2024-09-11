using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using PEDIDOS_APIREST.Models;

namespace PEDIDOS_APIREST.Data;

public partial class DbpedidosContext : DbContext
{
    public DbpedidosContext()
    {
    }

    public DbpedidosContext(DbContextOptions<DbpedidosContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Cliente> Clientes { get; set; }

    public virtual DbSet<DetallesPedido> DetallesPedidos { get; set; }

    public virtual DbSet<Pedido> Pedidos { get; set; }

}
