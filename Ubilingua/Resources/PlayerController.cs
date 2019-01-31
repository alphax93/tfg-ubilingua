using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour {

    public float speed = 1;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
        if (gameObject.tag == "Player1Hor")
        {

            if (Input.GetKey(KeyCode.A))
            {
                transform.position += speed * Vector3.left * Time.deltaTime;
            }
            if (Input.GetKey(KeyCode.D))
            {
                transform.position += speed * Vector3.right * Time.deltaTime;
            }

        }
        else if (gameObject.tag == "Player1Ver")
        {
            if (Input.GetKey(KeyCode.W))
            {
                transform.position += speed * Vector3.up * Time.deltaTime;
            }
            if (Input.GetKey(KeyCode.S))
            {
                transform.position += speed * Vector3.down * Time.deltaTime;
            }
        }
        else if (gameObject.tag == "Player2Hor")
        {

            if (Input.GetKey(KeyCode.LeftArrow))
            {
                transform.position += speed * Vector3.left * Time.deltaTime;
            }
            if (Input.GetKey(KeyCode.RightArrow))
            {
                transform.position += speed * Vector3.right * Time.deltaTime;
            }

        }
        else if (gameObject.tag == "Player2Ver")
        {
            if (Input.GetKey(KeyCode.UpArrow))
            {
                transform.position += speed * Vector3.up * Time.deltaTime;
            }
            if (Input.GetKey(KeyCode.DownArrow))
            {
                transform.position += speed * Vector3.down * Time.deltaTime;
            }
        }
    }
}
