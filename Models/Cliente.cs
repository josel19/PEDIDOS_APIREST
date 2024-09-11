using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace PEDIDOS_APIREST.Models;

public partial class Cliente
{
    [Key]
    public int ClienteId { get; set; }

    [StringLength(50)]
    public string Nombre { get; set; } = null!;

    [StringLength(50)]
    public string Apellido { get; set; } = null!;

    [StringLength(100)]
    public string? Correo { get; set; }

    [StringLength(15)]
    public string? Telefono { get; set; }

    public DateTime FechaCreacion { get; set; }

    [StringLength(20)]
    public string Estado { get; set; } = null!;

    [InverseProperty("Cliente")]
    public virtual ICollection<Pedido> Pedidos { get; set; } = new List<Pedido>();
}
