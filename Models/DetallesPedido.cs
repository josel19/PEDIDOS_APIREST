using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace PEDIDOS_APIREST.Models;

[Table("DetallesPedido")]
public partial class DetallesPedido
{
    [Key]
    public int DetallePedidoId { get; set; }

    public int PedidoId { get; set; }

    [StringLength(100)]
    public string NombreProducto { get; set; } = null!;

    public int Cantidad { get; set; }

    [Column(TypeName = "decimal(10, 2)")]
    public decimal PrecioUnitario { get; set; }

    public DateTime FechaCreacion { get; set; }

    [ForeignKey("PedidoId")]
    [InverseProperty("DetallesPedidos")]
    public virtual Pedido Pedido { get; set; } = null!;
}
