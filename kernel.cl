typedef struct
{
	int fila;
	int columna;
} Matriz;

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
				pos[cont+i*N*N].fila = F; 
				pos[cont+i*N*N].columna = C;
				cont++;

			}
		}
	}
	for(int j = 0; j < cont; j++)
	{
		for(int k = j+1; k < cont; k++)
		{
			distAux = abs(pos[j+i*N*N].fila - pos[k+i*N*N].fila) + abs(pos[j+i*N*N].columna - pos[k+i*N*N].columna);
			if(distAux > distancias[i])
			{
				distancias[i] = distAux;
			}
		}
	}
}