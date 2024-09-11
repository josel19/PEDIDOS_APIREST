using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace PEDIDOS_APIREST.Models;

public partial class Pedido
{
    [Key]
    public int PedidoId { get; set; }

    public int ClienteId { get; set; }

    public DateTime FechaPedido { get; set; }

    [Column(TypeName = "decimal(10, 2)")]
    public decimal MontoTotal { get; set; }

    public DateTime FechaCreacion { get; set; }

    [StringLength(20)]
    public string Estado { get; set; } = null!;

    [ForeignKey("ClienteId")]
    [InverseProperty("Pedidos")]
    public virtual Cliente Cliente { get; set; } = null!;

    [InverseProperty("Pedido")]
    public virtual ICollection<DetallesPedido> DetallesPedidos { get; set; } = new List<DetallesPedido>();
}
