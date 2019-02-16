using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemiesGeneratorScript : MonoBehaviour
{

    public int enemigosCount = 20;
    public GameObject[] enemyPrefab;
    public Transform spawnPoint;

    public float timeBetweenWaves = 5f;
    private float countdown = 2f;
    private GameObject newEnemy;
    bool generating = false;

    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {

    }

    void SpawnEnemy(int[] enemies)
    {
        int random = Random.Range(0, enemies.Length);
        newEnemy = Instantiate(enemyPrefab[enemies[random]], transform.position, transform.rotation);
        newEnemy.transform.SetParent(transform);


    }

    public void BegingWave(int numberOfWave, int enemyAmount)
    {
        generating = true;
        
        StartCoroutine(Respawn(numberOfWave, enemyAmount));
    }

    //TODO
    public void StopWave()
    {
        generating = false;
    }

    public int[] EnemyTypes(int numberOfWave)
    {
        switch (numberOfWave)
        {
            case 1: return new int[]{ 0 };
            case 2: return new int[] { 0 };
            case 3: return new int[] { 1 };
            case 4: return new int[] { 0, 1 };
            case 5: return new int[] { 2 };
            case 6: return new int[] { 0, 2 };
            case 7: return new int[] { 3 };
            case 8: return new int[] { 0, 3 };
            case 9: return new int[] { 4 };
            case 10: return new int[] { 0, 4 };
            case 11: return new int[] { 5 };
            default:
                
                int types = Random.Range(1, numberOfWave / 10 + 1);
                if (types > 5) types = 5;
                int[] enemies = new int[types];
                for (int i = 0; i < enemies.Length; i++)
                {
                    enemies[i] = Random.Range(0, enemyPrefab.Length);
                }
                return enemies;
        }
        
        
        
    }

    IEnumerator Respawn(int numberOfWave, int enemyAmount)
    {
        int[] enemies = EnemyTypes(numberOfWave);
        while (generating && enemyAmount>0)
        {
            
            SpawnEnemy(enemies);
            enemyAmount--;
           // //print("GENERANDO ENEMIGOS ");
            yield return new WaitForSeconds(countdown); //TODO: Calcular tiempo entre oleadas
        }
        ////print("ENTRA A STOP");
        StopWave();
        
    }

}