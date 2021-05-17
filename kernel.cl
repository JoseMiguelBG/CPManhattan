typedef struct 
{
	int fila;
	int columna;
} Matriz;

int calDistancia(Matriz posa, Matriz posb){
	int distancia = 0;
	distancia = abs(posb.fila - posa.fila) + abs(posb.columna - posa.columna);
	return distancia;
}

kernel void manhattan(int N,__global int *A,__global int *numeros,__global int *distancias,__global Matriz *pos){
    size_t i = get_global_id(0);
    size_t NumWrokItems = get_global_size(0);
    
    int k;
	int distAux;
	int cont;

	cont = 0;
	distancias[i] = 0;

	for (int F = 0; F < N; F++)
	{
		for (int C = 0; C < N; C++)
		{
			if(numeros[i]== A[F*N+C])
			{
				pos[0+i*N*N].fila = F; 
				pos[0+i*N*N].columna = C;
				cont++;
			}
		}
	}
	for(int j = 0; j < cont; j++)
	{
		for(int k = j+1; k < cont; k++)
		{
			distAux = calDistancia(pos[j+i*N*N], pos[k+i*N*N]);
			if(distAux > distancias[i])
			{
				distancias[i] = distAux;
			}
		}
	}
    delete pos;
}