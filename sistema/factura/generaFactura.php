<?php
session_start();
if (empty($_SESSION['active'])) {
    header('location: ../');
}
include "../../conexion.php";

if (empty($_REQUEST['cl']) || empty($_REQUEST['f'])) {
    echo "No es posible generar la factura.";
} else {
    $codCliente = $_REQUEST['cl'];
    $noFactura = $_REQUEST['f'];

    // Consultar configuración
    $consulta = mysqli_query($conexion, "SELECT * FROM configuracion");
    $resultado = mysqli_fetch_assoc($consulta);

    // Consultar venta
    $ventas = mysqli_query($conexion, "SELECT * FROM factura WHERE nofactura = $noFactura");
    $result_venta = mysqli_fetch_assoc($ventas);

    // Consultar cliente
    $clientes = mysqli_query($conexion, "SELECT * FROM cliente WHERE idcliente = $codCliente");
    $result_cliente = mysqli_fetch_assoc($clientes);

    // Consultar productos
    $productos = mysqli_query($conexion, "SELECT d.nofactura, d.codproducto, d.cantidad, p.codproducto, p.descripcion, p.precio FROM detallefactura d INNER JOIN producto p ON d.codproducto = p.codproducto WHERE d.nofactura = $noFactura");



	require_once 'fpdf/fpdf.php';
	$pdf = new FPDF('P', 'mm', array(90, 200));
	$pdf->AddPage();
	$pdf->SetMargins(5, 5, 5); //MARGEN DE FACTURAA
	$pdf->SetTitle("Factura de Venta");

	// Agregar logo
	$pdf->Image('img/logo4.jpeg', 0, 0, 90, 15, 'JPEG'); // Ajusta las coordenadas y el tamaño según sea necesario


    // Encabezado
    $pdf->Ln(2);
    $pdf->Ln(2);
    $pdf->SetFont('Arial', 'B', 10);
    $pdf->SetTextColor(33, 37, 41);
    $pdf->Cell(80, 8, utf8_decode($resultado['nombre']), 0, 1, 'C'); //NOMBRE DEL VENDEDOR
    $pdf->SetFont('Arial', '', 9);
    $pdf->Cell(80, 5, 'NIT: ' . $resultado['ci'], 0, 1, 'C');
    $pdf->Cell(80, 5, 'Telefono: ' . $resultado['telefono'], 0, 1, 'C');
    $pdf->Cell(80, 5, 'Correo: ' . $resultado['email'], 0, 1, 'C');
    $pdf->Cell(80, 5, utf8_decode('Dirección: ' . $resultado['direccion']), 0, 1, 'C');
    $pdf->Ln(2); //SALTO DE LINEA
    
    // Detalles de la factura
    $pdf->SetFont('Arial', 'B', 10);
    $pdf->SetFillColor(230, 230, 230);
    $pdf->Cell(80, 6, 'DETALLE DE FACTURA', 0, 1, 'C', true);
    $pdf->SetFont('Arial', '', 9);
    $pdf->Cell(80, 6, 'Ticket: ' . $noFactura, 0, 1, 'C');
    $pdf->Cell(80, 6, 'Fecha: ' . $result_venta['fecha'], 0, 1, 'C');
    $pdf->Ln(2);
    
    // Detalles del cliente
    $pdf->SetFont('Arial', 'B', 10);
    $pdf->Cell(80, 6, 'DATOS DEL CLIENTE', 0, 1, 'C', true); // EL 6 ES EL ANCHO DEL COLOR PLOMO
    $pdf->SetFont('Arial', '', 9);
    $pdf->Cell(80, 6, utf8_decode($result_cliente['nombre']), 0, 1, 'C');
    $pdf->Cell(80, 6, 'Ci: ' . $result_cliente['ci'], 0, 1, 'C');
    $pdf->Cell(80, 6, 'Telefono: ' . $result_cliente['telefono'], 0, 1, 'C');
    $pdf->Cell(80, 6, utf8_decode('Dirección: ' . $result_cliente['direccion']), 0, 1, 'C');
    $pdf->Ln(2);
    
    // Detalle de productos
    $pdf->SetFont('Arial', 'B', 10);
    $pdf->Cell(80, 6, 'DETALLES DE PRODUCTOS', 0, 1, 'C', true);
    $pdf->SetFont('Arial', 'B', 9);
    $pdf->Cell(45, 6, 'Descripcion', 1, 0, 'C');
    $pdf->Cell(10, 6, 'Cant', 1, 0, 'C');
    $pdf->Cell(12, 6, 'Precio', 1, 0, 'C');
    $pdf->Cell(13, 6, 'Total', 1, 1, 'C');
    
    $pdf->SetFont('Arial', '', 8); // TAMAÑO DE TEXTO MOI
    while ($row = mysqli_fetch_assoc($productos)) {
        $pdf->Cell(45, 6, utf8_decode($row['descripcion']), 1, 0, 'L');
        $pdf->Cell(10, 6, $row['cantidad'], 1, 0, 'C');
		$pdf->Cell(12, 6, number_format($row['precio'], 0, '.', ',') . 'Bs', 1, 0, 'R');


        $importe = number_format($row['cantidad'] * $row['precio'], 0, '.', ',') . 'Bs';
		$pdf->Cell(13, 6, $importe, 1, 1, 'R');


    }
    
    // Total
    $pdf->SetFont('Arial', 'B', 8);
    $pdf->Cell(67, 6, 'Total: ', 1, 0, 'R');
    $pdf->Cell(13, 6, number_format($result_venta['totalfactura'], 0, '.', ',') . 'Bs', 1, 1, 'R');


    $pdf->Ln(2);
    
    // Mensaje de agradecimiento
    $pdf->SetFont('Arial', '', 8);
    $pdf->Cell(80, 6, utf8_decode("Gracias por su preferencia"), 0, 1, 'C');

    // Limpiar cualquier salida previa
    ob_end_clean();

    $pdf->Output("compra.pdf", "I");
}
?>
